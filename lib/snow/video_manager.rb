class VideoManager

  def video_published?(lesson_name, language)
    root = "http://content.blubrry.com/railsmania/"
    # Legacy, previously published lessons we need to map the names or republish everything.
    legacy_files = {
      en: {
        "bob/bob01" => "themed_bob_01.mp4",
        "bob/bob02" => 'themed_bob_02.mp4',
        'bob/bob03' => 'themed_bob_03.mp4',
        'bob/bob04' => 'themed_bob_04.mp4',
        'bob/bob05' => 'themed_bob_05.mp4',
        'foundation/ide/editor' =>  'foundation_development_environment.mp4',
        'foundation/hello_world/rails_hello_world' => 'foundation_rails_hello_world.mp4',
        'foundation/routing/1.understanding_routes' => 'understanding_routes.mp4',
        'foundation/routing/2.resourceful_routes' => '2.en.foundation.routing.resourceful.mp4',
        'foundation/routing/3.add_restful_to_resourcefuL_routes' => '3.en.foundation.routes.restful_resourceful_routes.mp4',
        'foundation/gems/1.basics' => '1.en.foundation.gems.basic.mp4',
        'foundation/gems/2.versioning' => '2.en.gems_versioning.mp4',
        'foundation/gems/3.advance_gemfile_lock_and_sources' => '3.en.gems_local_rubygems_lock_file.mp4'
      },
      es: {
        "bob/bob01" => "themed_bob_01_es.mp4",
        "bob/bob02" => 'themed_bob_02_es.mp4',
        'bob/bob03' => 'es_bob03.mp4',
        'bob/bob04' => 'es_bob04.mp4',
        'bob/bob05' => 'es_bob05.mp4',
        'foundation/ide/editor' => 'es_foundation_ide.mp4',
        'foundation/hello_world/rails_hello_world' => 'es_foundation_hello_world.mp4',
        'foundation/routing/1.understanding_routes' => '1.es.understanding_routes.mp4',
        'foundation/routing/2.resourceful_routes' => '2.es.foundation.routing.resourceful.mp4',
        'foundation/routing/3.add_restful_to_resourcefuL_routes' => '3.es_foundation_routes.mp4',
        'foundation/gems/1.basics' => 'es_gemas01.mp4',
        'foundation/gems/2.versioning' => 'gemas02.mp4'
      },
      ja: {
        'foundation/ide/editor' => 'foundation_development_environment_ja.mp4',
        'foundation/hello_world/rails_hello_world' => 'foundation_rails_hello_world_ja.mp4'
      }
    }
    if legacy_files[language][lesson_name]
      url = root + legacy_files[language][lesson_name].to_s
    else
      url = root + lesson_name.split('/').last + '_' + language.to_s + '.mp4'
    end
    uri = URI(url)
    request = Net::HTTP.new uri.host
    response= request.request_head uri.path
    response.code.to_i == 200
  end

end