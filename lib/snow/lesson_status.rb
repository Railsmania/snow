class LessonStatus

  #Each language has a different workflow
  def lesson_status(name, language)
    if language == :en
      lesson_status_en(name)
    elsif language == :es
      lesson_status_es(name)
    end
    #TODO: support japanese
  end

  def self.script_done?(status)
    ['record video', 'record audio', 'camtasia', 'publish video', 'publish site', 'DONE'].include?(status)
  end

  private

  def next_action(stages)
    option = false
    stages.each_pair do |next_step, condition|
      result = condition.call # the call may be expensive
      if result == false # if we have an optional step return that intead
        return option || next_step
      elsif result == :option #if fail in optional step, just record it
        option = option || next_step
      else # if passed then delete options
        option = false
      end
    end
    'DONE'
  end

  # The lambda if true, then we keep working, else we failed and we recommend to do what we have on the left
  # We only show the optional ones if subsequent steps failed. If the next mandatory step passed then we ignore
  # the options
  def lesson_status_en(lesson_name)
    dropbox_dir = DropboxDir.new(DROPBOX_ROOT, :en)
    stages = {'script' => ->{ScriptsDir.new.done?(lesson_name + '_en.md')},
      'record audio' => ->{(dropbox_dir.has_audio?(lesson_name) && !dropbox_dir.has_video?(lesson_name)) || :option},
      'record video' => ->{(dropbox_dir.has_video?(lesson_name) && !dropbox_dir.has_audio?(lesson_name)) || :option},
    #  'camtasia' => ->{(dropbox_dir.has_audio?(lesson_name) && dropbox_dir.has_video?(lesson_name)) || :option},
      'camtasia' => ->{dropbox_dir.has_project?(lesson_name)},
      'publish video' => ->{VideoManager.new.video_published?(lesson_name, :en)},
      'publish_site' => ->{Site.new.published?(lesson_name, :en)}
    }

    next_step = next_action(stages)
    if next_step == 'script'
     ScriptsDir.new.status?(lesson_name + '_en.md')
    else
      next_step
    end
  end

  def lesson_status_es(lesson_name)
    dropbox_dir = DropboxDir.new(DROPBOX_ROOT, :es)

    stages = {
      'translate' => ->{ ScriptsDir.new.done?(lesson_name + '_es.md')},
      'share translation' => ->{ dropbox_dir.has_translation?(lesson_name) || :option },
      'share en video' => ->{dropbox_dir.has_original_video?(lesson_name) || :option},
      'wait es video' => ->{dropbox_dir.has_translated_video?(lesson_name) || :option},
      'review video' => ->{dropbox_dir.has_finished_video?(lesson_name) || :option},
      'publish video' => ->{ VideoManager.new.video_published?(lesson_name, :es)},
      'publish site' => ->{Site.new.published?(lesson_name, :es)}
   # 'DONE' => ->{VideoManager.new.video_published?(lesson_name, :es)} #TODO publish_site
    }

    next_action(stages)

    # TODO: support projects
    # TODO: support payments
  end


end