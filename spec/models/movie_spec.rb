require 'spec_helper'

describe Movie do
  describe 'finding similar movies' do
    it 'should find no other movies when director is unique' do
      fixture = FactoryGirl.build(:movie, :director => 'Unique Director')
      fixture.save!
      FactoryGirl.build(:movie, :director => 'Steven Spielberg').save!
      movies = fixture.find_movies_with_same_director
      movies.length.should == 0
    end
    it 'should find other movie when other movie has same director' do
      fixture = FactoryGirl.build(:movie, :title => 'Dummy', :director => 'Steven Spielberg')
      fixture.save!
      FactoryGirl.build(:movie, :title => 'Back To The Future', :director => 'Steven Spielberg').save!
      movies = fixture.find_movies_with_same_director
      movies.length.should == 1
    end
    it 'should find no other movies when director is nil' do
      fixture = FactoryGirl.build(:movie, :director => nil)
      fixture.save!
      FactoryGirl.build(:movie, :director => nil).save!      
      movies = fixture.find_movies_with_same_director
      movies.length.should == 0
    end
  end
end