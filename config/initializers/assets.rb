# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path
Rails.application.config.assets.paths << Rails.root.join('node_modules')


# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/
Rails.application.config.assets.precompile += %w( *.png *.jpg *.jpeg *.gif )
Rails.application.config.assets.precompile += %w( admin.css admin.js admin/* )
Rails.application.config.assets.precompile += %w( jquery-fileupload/index.js ) # for jquery-fileupload-rails gem?
Rails.application.config.assets.precompile += %w( articles.js )
Rails.application.config.assets.precompile += %w( users.js )
Rails.application.config.assets.precompile += %w( users_datatables.js )
Rails.application.config.assets.precompile += %w( articles_datatables.js )
Rails.application.config.assets.precompile += %w( dist/dragula.js )
Rails.application.config.assets.precompile += %w( dragula.min.js )
Rails.application.config.assets.precompile += %w( example/example.min.js )
Rails.application.config.assets.precompile += %w( dist/dragula.min.js )
Rails.application.config.assets.precompile += %w( project_examine.css )
Rails.application.config.assets.precompile += %w( project_details.js )