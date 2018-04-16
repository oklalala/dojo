namespace :dev do
  task fake_all: :environment do
    Rake::Task['db:seed'].execute
    Rake::Task['dev:fake_user'].execute
    # Rake::Task['dev:fake_friendship'].execute
    Rake::Task['dev:fake_post'].execute
    # Rake::Task['dev:fake_comment'].execute
    # Rake::Task['dev:fake_collect'].execute
    # Rake::Task['dev:fake_sort'].execute
  end

  task fake_user: :environment do
    num = [*0..72].sample(20)
    30.times do |i|
      avatar = "pic1_#{num[i].to_s.rjust(3, '0')}.jpg"
      User.create!(
        id: i + 3,
        name: FFaker::Name.first_name,
        avatar: File.new(Rails.root.join('app', 'assets', 'images', avatar)),
        email: FFaker::Internet.email,
        intro: FFaker::Lorem.paragraph,
        password: "123123"
      )
    end
    puts "have created fake users"
    puts "now you have #{User.count} users data"
  end

  task fake_post: :environment do
    Post.destroy_all
    200.times do |i|
      # photo = "pic1_#{rand(72).to_s.rjust(3, '0')}.jpg"
      file = File.new(Rails.root.join('app', 'assets', 'images', "pic1_#{rand(72).to_s.rjust(3, '0')}.jpg"))
      Post.create!(
        id: i + 1,
        photo: file,
        title: FFaker::Name.first_name,
        content: FFaker::Lorem.paragraph,
        status: nil,
        comments_count: rand(20),
        viewed_count: rand(60),
        who_can_see: nil,
        user_id: User.all.sample.id
      )
    end
    puts "have created fake Posts"
    puts "now you have #{Post.count} posts data"
  end

  task fake_comment: :environment do
    Comment.destroy_all
    Post.all.each do |post|
      rand(6).times do |i|
        post.comments.create!(
          content: FFaker::Lorem.paragraph,
          user: User.all.sample
        )
      end
    end
    puts "have created fake comments"
    puts "now you have #{Comment.count} comments data"
  end

  task fake_collect: :environment do
    collect.destroy_all
    User.all.each do |user|
      rand(50).times do
        user.collects.create!(
          user_id: user.id,
          post_id: Post.all.sample.id
        )
      end
    end
    Post.all.each do |post|
      post.collects_count = Collect.where(post_id: post.id).count
      post.save
    end
    puts "have created fake collects"
    puts "now you have #{collect.count} collects data"
  end

  task fake_followship: :environment do
    Followship.destroy_all
    User.all.each do |user|
      rand_user = User.select{|x| x!=user}.sample(5)
      rand(5).times do |i|
        user.followships.create!(
          user_id: user.id, 
          following_id: rand_user[i].id)
      end
    end
   
    puts "have created fake followship"
    puts "now you have #{Followship.count} followships data"
  end

  task fake_friendship: :environment do
    Friendship.destroy_all
    User.all.each do |user|
      rand_user = User.select{|x| x!=user}.sample(5)
      rand(5).times do |i|
        user.friendships.create!(
          user_id: user.id, 
          friend_id: rand_user[i].id)
      end
    end
   
    puts "have created fake friendship"
    puts "now you have #{Friendship.count} friendships data"
  end

  # task fake_p: :environment do
  #   uploaders = Restaurant.first(10).map(&:image)
  #   Restaurant.last(490).each do |restaurant|
  #     restaurant.image = uploaders.sample
  #   end
  #   puts "other fake image"
  # end
end