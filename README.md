
# neography_test

This simple **[ruby](http://www.ruby-lang.org/)** app demonstrates how to use the **[neo4j graph database](http://www.neo4j.org/)** through the **[neography](https://github.com/maxdemarzi/neography)** gem.

## Setup

```bash
# bash
git clone https://github.com/fiedl/neography_test
cd neography_test
bundle install
bundle exec rake neo4j:install
bundle exec rake neo4j:start
```

This will neo4j and start a database server in the background.

## Starting the Script

```
# bash
bundle exec ruby neography_test.rb
```

## Data Visualization

The graph data, created in [./neography_test.rb](neography_test.rb) can be visualized using ...

## Data Manipulation

You can play around with the data, either in the regular ruby console, or using `pry`:



## Resources
* http://maxdemarzi.com/2012/01/04/getting-started-with-ruby-and-neo4j/
* https://github.com/maxdemarzi/neography

