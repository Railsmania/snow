class Site
  def published?(lesson_name, language)
    return true
    # TODO: implement this
    lesson_title = ScriptsDir.new.lesson_title(lesson_name+ '_en.md')
    puts lesson_title_to_url(lesson_title, language)
    uri = URI(lesson_title_to_url(lesson_title, language))
    #TODO: why we get 301 when using head?
    response = Net::HTTP.get_response(uri)
    puts response.code
    response.code.to_i == 200
  end

  private
  def lesson_title_to_url(lesson_title, language)
    slub = lesson_title.downcase.gsub(' ', '-') + '/'
    url_base(language) + slub
  end

  def url_base(language)
    if language == :en
      'https://railsmania.com/en/lessons/'
    elsif language == :es
      'https://railsmania.com/es/lessons/'
    else
      raise 'language not supported'
    end
  end

end