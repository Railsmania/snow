class DropboxDir

  def initialize(dropbox_root, language)
    @dropbox_root = dropbox_root
    @language = language
  end

  # If we find a project we assume it already has video and audio and thus
  # we do not care to check for those files
  def lesson_status(lesson_name)
    if has_project?(lesson_name)
      'project'
    elsif has_audio?(lesson_name)
      'audio'
    elsif has_video?(lesson_name)
      'video'
    else
      'script'
    end
  end

  def has_project?(lesson_name)
    files(camtasia_dir, 'cmproj').include?(lesson_name + '.cmproj')
  end

  def has_audio?(lesson_name)
    files(audio_dir, 'mp3').include?(lesson_name + '.mp3')
  end

  def has_video?(lesson_name)
    files(video_dir, 'mp4').include?(lesson_name + '.mp4')
  end

  def has_finished_video?(lesson_name)
    files(finished_videos_dir, 'mp4').include?(lesson_name + '.mp4')
  end

  def has_translation?(lesson_name)
    files(shared_translations_dir, 'md').include?(lesson_name + '.md')
  end

  def has_original_video?(lesson_name)
    files(shared_translations_dir, 'mp4').include?(lesson_name + '.mp4')
  end
  def has_translated_video?(lesson)
    false
  end

  private
  def shared_translations_dir
    File.expand_path(File.join(@dropbox_root, 'videos_sergio/'))
  end

  def finished_videos_dir
    File.expand_path(File.join(@dropbox_root, 'RailsMania/es/lessons/'))
  end

  def files(dir, file_extension)
    return [] if dir.nil? || dir.empty?
    all_files = Dir.glob("#{dir}/**/*.#{file_extension}")
    # adding an extra / so we delete that character also from the project name
    all_files.map{|file| file.gsub(dir+'/', '')}
  end

  def video_dir
    File.expand_path(File.join(@dropbox_root, 'RailsMania/lessons/raw_video/'))
  end

  def audio_dir
    File.expand_path(File.join(@dropbox_root, 'RailsMania/lessons/raw_audio/'))
  end

  def camtasia_dir
    if @language == :en
      File.expand_path(File.join(@dropbox_root, 'RailsMania/lessons/camtasia_projects/'))
    elsif @language == :es
      File.expand_path(File.join(@dropbox_root, 'RailsMania/es/camtasia_projects/'))
    else
      ''
    end
  end

end
