require 'fileutils'

class ScriptsDir
  DATA_DIR = 'data'
  SCRIPTS_DIR = File.join(DATA_DIR, 'scripts')
  SCRIPTS_REPO = 'git@github.com:Railsmania/scripts.git'

  def all_md_files
    pull_or_clone_repo

    all_files = Dir.glob("#{dir}/**/*").select{|filename| File.file?(filename)}

    md_files = all_files.select{|filename| filename.end_with?('.md')}
    #TODO: support alternative files
    md_files.delete_if{|filename| filename.end_with?('alt.md')}
  end

  def status?(file)
    path = File.join(dir, file)
    first_line = File.open(path, &:readline)
    if first_line && first_line.match(/\s*\[(.*)\]\s*/)
      first_line.match(/\s*\[(.*)\]\s*/)[1]
    else
      'yes'
    end
  end


  private
  def pull_or_clone_repo
    puts 'updating repo information'
    # the directory under which we will clone the repo
    data_dir = File.join(snow_root, DATA_DIR)
    # Create dir if it is not there yet
    FileUtils.mkdir_p(data_dir)
    # if nothing there, we need to clone for the first time, else, update
    if Dir[File.join(data_dir, '*')].empty?
      `cd #{data_dir} && git clone #{SCRIPTS_REPO}`
    else
      `cd #{dir} && git pull origin master`
    end
  end

  def dir
    File.join(snow_root, SCRIPTS_DIR)
  end

  def snow_root
    File.join(File.dirname(__FILE__), '/../../')
  end
end