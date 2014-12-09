class DropboxDir


  def initialize(dropbox_root)
    @dropbox_root = dropbox_root
  end

  def has_lesson?(lesson_name)
    camtasia_projects.include?(lesson_name + '.cmproj')
  end

  def camtasia_projects
    @camtasia_projects ||= begin
      camtasia_files = Dir.glob("#{camtasia_dir}/**/*.cmproj")
      # adding an extra / so we delete that character also from the project name
      camtasia_files.map{|file| file.gsub(camtasia_dir+'/', '')}
    end
  end

  private
  def camtasia_dir
    File.expand_path(File.join(@dropbox_root, 'RailsMania/lessons/camtasia_projects/'))
  end
end