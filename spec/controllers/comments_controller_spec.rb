require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe CommentsController do

  before(:each) { @article = FactoryGirl.create(:article)}


  # This should return the minimal set of attributes required to create a valid
  # Comment. As you add validations to Comment, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "content" => "MyText", "article_id" => @article.id } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CommentsController. Be sure to keep this updated too.
  let(:valid_session) { {} }


  describe "POST create" do
    describe "with valid params" do
      it "creates a new Comment" do
        expect {
          post :create, {:article_id => @article, :comment => valid_attributes}, valid_session
        }.to change(Comment, :count).by(1)
      end

      it "assigns a newly created comment as @comment" do
        post :create, {:article_id => @article, :comment => valid_attributes}, valid_session
        assigns(:comment).should be_a(Comment)
        assigns(:comment).should be_persisted
      end

      it "redirects to the created comment" do
        post :create, {:article_id => @article, :comment => valid_attributes}, valid_session
        response.should redirect_to(@article)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved comment as @comment" do
        # Trigger the behavior that occurs when invalid params are submitted
        Comment.any_instance.stub(:save).and_return(false)
        post :create, {:article_id => @article, :comment => { "article_id" => @article.id }}, valid_session
        assigns(:comment).should be_a_new(Comment)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Comment.any_instance.stub(:save).and_return(false)
        post :create, {:article_id => @article, :comment => { "article_id" => @article.id }}, valid_session
        response.should redirect_to(@article)
      end
    end
  end

end
