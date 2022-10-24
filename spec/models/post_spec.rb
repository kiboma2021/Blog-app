require 'rails_helper'

testing_text = 'Lorem ipsum dolor sit amet consectetur
                            adipisicing elit. Est eaque voluptate reprehenderit
                             inventore ducimus facilis tempore nesciunt, nisi
                            sapiente esse. Eveniet eos fugit labore veritatis
                            est ipsum non! Vel ut inventore ratione officia quos
                            fuga vitae enim atque, ullam sint sunt consequatur non
                            perspiciatis nemo corporis rem eos quam dignissimos
                            exercitationem ad recusandae! Aliquid architecto perspiciatis
                            nesciunt reiciendis quasi beatae esse unde reprehenderit obcaecati
                            laudantium aspernatur non tenetur ut, doloribus accusamus assumenda
                            iusto sapiente odio. Distinctio enim eius consequuntur illum atque
                            repellat molestiae neque porro modi. Et, quia corrupti repudiandae
                            autem magni a vitae. Sint, soluta libero sit id totam, voluptatum
                            doloribus eaque assumenda animi quos nulla non tenetur labore
                            obcaecati? Veniam, mollitia voluptatibus. Fuga, perferendis?
                            Libero officiis natus maxime voluptatum accusamus nesciunt,
                            dolorem quia? Ratione incidunt deleniti nisi exercitationem
                            ducimus voluptas quam impedit laudantium officia eos accusamus
                            fugiat repellendus, cum illo eum aut, excepturi itaque
                            nesciunt porro distinctio est optio libero. Itaque
                            voluptatem dolorem illo voluptates blanditiis? Temporibus
                            incidunt necessitatibus ipsa? Eveniet autem consequuntur
                            distinctio aliquid exercitationem. Id et modi saepe esse
                            nesciunt mollitia repudiandae cum, reiciendis eos officiis
                            voluptatem consequatur consectetur qui magni aut non fugiat
                            cupiditate natus iste expedita culpa quo? Perspiciatis
                            repudiandae quos esse ipsa iure. Inventore laborum ut accusamus
                            eum nobis quos fugiat recusandae, iste id necessitatibus eaque
                            dolor dolores temporibus nesciunt velit numquam sint sapiente
                            voluptates eligendi quasi officiis quidem pariatur, a esse!
                            Aut ipsum odit recusandae quaerat, porro delectus voluptate,
                            voluptatum est sapiente quisquam vel odio minima laudantium
                            facere? Error quae, sequi quaerat aliquid similique natus,
                            exercitationem molestias magnam dolore minus, harum maiores?
                            Nihil nisi nostrum, omnis doloremque ducimus aliquid repudiandae
                            quia temporibus quos illum numquam fugit hic reiciendis ex porro
                            consequuntur minima, perspiciatis iure sit necessitatibus!
                            Pariatur quod repudiandae, veritatis itaque rerum sapiente
                            perspiciatis, error quis ex temporibus amet, optio consequuntur
                            voluptate!'
RSpec.describe Post, type: :model do
  before :each do
    @first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                              bio: 'Teacher from Mexico.', posts_counter: 0)
    @first_user.save

    @first_post = Post.new(author: @first_user, title: 'First post', text: 'First post by first user',
                           comments_counter: 0, likes_counter: 0)
    @first_post.save
  end

  context 'Validate:' do
    it 'should be valid' do
      expect(@first_post).to be_valid
    end

    it 'should have text' do
      test_post = Post.new(author: @first_user, title: 'First post',
                           comments_counter: 0, likes_counter: 0)
      expect(test_post).to_not be_valid
    end

    it 'should have comment_counter' do
      test_post = Post.new(author: @first_user, title: 'First post', text: 'First post by first user',
                           likes_counter: 0)
      expect(test_post).to_not be_valid
    end

    it 'comment_counter should be greater than 0' do
      test_post = Post.new(author: @first_user, title: 'First post', text: 'First post by first user',
                           comments_counter: -1, likes_counter: 0)

      expect(test_post).to_not be_valid
    end

    it 'should have likes_counter' do
      test_post = Post.new(author: @first_user, title: 'First post', text: 'First post by first user',
                           comments_counter: 0)
      expect(test_post).to_not be_valid
    end

    it 'like_counter should be greater than 0 ' do
      test_post = Post.new(author: @first_user, title: 'First post', text: 'First post by first user',
                           comments_counter: 0, likes_counter: -1)

      expect(test_post).to_not be_valid
    end
  end

  context 'Validating text' do
    it 'should have max of 250 length text' do
      test_post = Post.new(author: @first_user, title: 'First post',
                           text: testing_text, comments_counter: 0, likes_counter: 0)

      expect(test_post).to_not be_valid
    end
  end

  context 'Methods:' do
    it 'should update_post_counter' do
      prev_post_counter = @first_user.posts_counter
      @first_post.update_posts_count
      posts_counter = @first_user.posts_counter
      expect(posts_counter).to be prev_post_counter + 1
    end

    it 'should return most recent comments' do
      new_comment = Comment.create(author: @first_user, post: @first_post, text: 'new Comment')
      new_comment.save
      recent_comment = @first_post.most_recent_comments
      expect(recent_comment).to eq([new_comment])
    end

    it 'should return most recent comments' do
      first_comment = Comment.create(author: @first_user, post: @first_post, text: 'new Comment 1')
      first_comment.save
      second_comment = Comment.create(author: @first_user, post: @first_post, text: 'new Comment 2')
      second_comment.save
      third_comment = Comment.create(author: @first_user, post: @first_post, text: 'new Comment 3')
      third_comment.save
      fourth_comment = Comment.create(author: @first_user, post: @first_post, text: 'new Comment 4')
      fourth_comment.save
      fifth_comment = Comment.create(author: @first_user, post: @first_post, text: 'new Comment 5')
      fifth_comment.save
      sixth_comment = Comment.create(author: @first_user, post: @first_post, text: 'new Comment 6')
      sixth_comment.save

      recent_comments = @first_post.most_recent_comments
      expected_comments = [sixth_comment, fifth_comment, fourth_comment, third_comment, second_comment]
      expect(recent_comments).to eq expected_comments
    end
  end
end
