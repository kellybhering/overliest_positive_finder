# What is this app for?

This app is your helper to detect overly positive reviews over the web.

# How does it work?

Through checking some rules in an specific review, it's is capable to compute an score to it. Scores goes from *0* to *100*. The *lesser* the score, the *"overliest" positive* the review is.

The top 3 *"overliest positive"* reviews are printed on you console then.


_Dealer Rater Example_

Running the application with no configuration set, Dealer Rater's Review Site will be the target.

At the end, this app will print Dealer Rater's 3 "overliest" review on your screen.

Dealer Rater's score calculations is based on:

    1-) Rating: reviews with max rating looses 10 score points
    
    2-) Detailed Rating: reviews with detailed ratings all filled with max rating OR with only `overall experience` and max rating looses 9 score points

    3-) Title word matching: it's possible to match some regex patterns to the title. Each pattern has a weight telling how many score points are going to be lost if there's a match. Current title's checked pattern matchers are:
        a-) It matches /best/ and 2 score points are lost (the word `best` has to be in the title)
        b-) It matches /great/ and 2 score points are lost (the word `great` has to be in the title)
        c-) It matches /(?=.*best)(?=.*place)(?=.*(car|vehicle))/ and 4 score points are lost (the words `best`,`place` and `car` or `vehicle` have to be in the title )

    4-) Text word matching: it's possible to match some regex patterns to the review text. Each pattern has a weight telling how many score points are going to be lost if there's a match. Current text's checked pattern matchers are:
        a-) It matches `/lord/` and 3 score points are lost (the word `lord` has to be in the text)
        b-) It matches `/miracle/` and 4 score points are lost (the word `miracle` has to be in the text)
        b-) It matches `/perfect/` and 4 score points are lost (the word `perfect` has to be in the text)
        c-) It matches `/(?=.*(greatest|nicest|best))(?=.*(salesmen|salesman|saleswoman|sellers|salespeople))/` and 5 score points are lost (words `greatest or nicest or best` and `salesmen or salesman or saleswoman or sellers or salespeople` have to be in the text)


# Running the application

For a better experience running the application and executing tests, a docker-compose was included. So, to execute it run the commands below:

_App_

```docker-compose up app```

_Tests_

```docker-compose run app bundle exec rspec```


### Linux/Ubuntu docker installation
```
$ sudo apt-get update
$ sudo apt-get install docker
$ sudo apt-get install docker-compose
```

### Mc docker installation
```
$ brew install docker
$ brew install docker-compose
```

- [Docker](https://docs.docker.com/engine/installation/)
- [Docker Compose](https://docs.docker.com/compose/install/#install-compose)


# What if I don't want to run it from docker?

Then you'll have to install some tools, they are:

    1-) Ruby 2.6.0 (you can use `rbenv` or `rvm`)
    2-) libxml2-dev libxslt-dev linux packages


Once installed run these commands from the project's directory to set it up:

```
 gem install bundler -v 1.17.3
 bundle config build.nokogiri --use-system-libraries
 bundle install
```

Now you just have to use the command ```ruby app.rb``` to run it or ```bundle exec rspec``` to run the tests.


# Improvements needed


1-) Parameterize score rules outside the file code
2-) Error handling ^^
3-) Parameterize how many reviews are going to be printed
4-) Check why VCR is not working properly
5-) Print review's detailed rating