require 'spec_helper'

describe MoviesController do
  describe 'finding similar movies' do
    # before :each do
      # @fake_results = [mock('Movie'), mock('Movie')]
    # end
    # it 'should call the model method that performs TMDb search' do
      # Movie.should_receive(:find_in_tmdb).with('hardware').
        # and_return(@fake_results)
      # post :search_tmdb, {:search_terms => 'hardware'}
    # end
    # describe 'after valid search' do
      # before :each do
        # Movie.stub(:find_in_tmdb).and_return(@fake_results)
        # post :search_tmdb, {:search_terms => 'hardware'}
      # end
      # it 'should select the Search Results template for rendering' do
        # response.should render_template('search_tmdb')
      # end
      # it 'should make the TMDb search results available to that template' do
        # assigns(:movies).should == @fake_results
      # end
    # end
    # it 'should to call the model method that performs movie lookup' do
      # @fake_movie = mock('Movie')
      # Movie.stub(:find).with().and_return(@fake_movie)
    # end
    before(:each) do
      Movie.stub!(:find).and_return(@mock_movie = mock('Movie'))
      @mock_movie.stub!(:director).and_return("Steven Spielberg")
      @mock_movie.stub!(:id).and_return(1)
    end
    it 'should not change template if director is nil' do
      @mock_movie.stub!(:director).and_return(nil)
      get 'similar', :id => @mock_movie.id
      flash.now[:notice].should == 'Movie director is empty. Search not performed.'
    end
    it 'should render similar template with no movies and notice if unique director' do
      # unique director, therefore empty list returned
      @mock_movie.stub!(:find_movies_with_same_director).and_return([]) 
      get 'similar', :id => @mock_movie.id
      flash.now[:notice].should == 'No similar movies found.'
      # response.should render_template('similar')
    end
    it 'should render similar template with movies of same directors if director is common' do
      # unique director, therefore empty list returned
      @mock_movie.stub!(:find_movies_with_same_director).and_return([mock('Movie')]) 
      get 'similar', :id => @mock_movie.id
      flash.now[:notice].should be_nil
      # response.should render_template('similar')      
    end
  end
end