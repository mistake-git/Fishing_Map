require 'test_helper'

class CommentTest < ActiveSupport::TestCase
 
    test "create_comment" do
     comment = Comment.create(id:100,content:'いいですね')
     assert_equal('いいですね',comment.content)
    end
    
    test "update_comment" do
     comment = Comment.create(id:100,content:'いいですね')
     comment.update(content: '最高です')
     assert_equal('最高です',comment.content)
    end
   
    test "destroy_comment" do
     comment = Comment.create(id:100,content:'いいですね')
     comment.destroy
     assert_empty(Comment.where(id: 100))
   end
end
