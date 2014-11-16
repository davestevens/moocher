namespace :heroku do

  desc "Deploy to heroku with compiled assets (production)"
  task :deploy do
    branch = `git rev-parse --abbrev-ref HEAD`
    `git checkout -b deploy`
    `RAILS_ENV=production bundle exec rake assets:precompile`
    `git add .`
    `git commit -am 'Include compiled assets.'`
    `git push -f heroku deploy:master`
    `git checkout #{branch}`
    `git branch -D deploy`
  end
end
