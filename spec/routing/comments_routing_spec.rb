require "spec_helper"

describe CommentsController do
  describe "routing" do

    it "routes to #index" do
      get("/comments").should_not be_routable
    end

    it "routes to #new" do
      get("/comments/new").should_not be_routable
    end

    it "routes to #show" do
      get("/comments/1").should_not be_routable
    end

    it "routes to #edit" do
      get("/comments/1/edit").should_not be_routable
    end

    it "routes to #create" do
      post("articles/1/comments").should route_to("comments#create", :article_id => "1")
    end

    it "routes to #update" do
      put("/comments/1").should_not be_routable
    end

    it "routes to #destroy" do
      delete("/comments/1").should_not be_routable
    end

  end
end
