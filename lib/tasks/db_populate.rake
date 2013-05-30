desc "clear current database, relaod schema and seeds"
namespace :db do
	task :populate => :environment do
		Rake::Task["db:drop"].execute
		Rake::Task["db:create"].execute
		Rake::Task["db:migrate"].execute
		Rake::Task["cache:flush"].execute
		Rake::Task["db:seed"].execute
		Rake::Task["cache:flush"].execute
	end
end