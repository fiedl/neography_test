# neography_test

This simple **[ruby](http://www.ruby-lang.org/)** app demonstrates how to use the **[neo4j graph database](http://www.neo4j.org/)** through the **[neography](https://github.com/maxdemarzi/neography)** gem.

## Setup

**Ruby Version**: Since this test script uses the [Hash](http://ruby-doc.org/core-2.0/Hash.html) class, this script requires ruby 2.0.0 or higher. (Recommendation: [rbenv](https://github.com/sstephenson/rbenv/) greatly simplifies the installation of different ruby versions.)

Download and install this test script like this:

```bash
# bash
git clone https://github.com/fiedl/neography_test
cd neography_test
bundle install
bundle exec rake neo4j:install
bundle exec rake neo4j:start
```

This will install neo4j and start a database server in the background.

## Script Versions

This script is provided in several versions, each using a different level of abstraction regarding the interaction with the neo4j database. 

1.  Check out the [neography-phase-1 tag](https://github.com/fiedl/neography_test/tree/neography-phase-1), where the script interacts with the neo4j database using the methods described at https://github.com/maxdemarzi/neography#usage.

2.  Check out the [neography-phase-2 tag](https://github.com/fiedl/neography_test/tree/neography-phase-1), where the script interacts with the neo4j database using the methods described at https://github.com/maxdemarzi/neography#phase-2, which are more abstract than using phase 1.

    There are two caveats about this approach: (a) For each object, a separate Rest interface object is created. (b) The `Person` class inherits from `Neography::Node`, which means that it can't possibly inherit from `ActiveRecord::Base`.

    One could get around (a) by initiating an interface `@neo`, manually, as shown in step 1, and keeping it as a class variable. (b) could be solved by storing the `Neography::Node` instance as instance variable of the `NeoObject` and then delegating the methods, also as used in step 1. But, hopefully, both steps will become unnecessary when moving to abstraction level 3, i.e. using an `ActiveRecord` adapter for neo4j.


## Starting the Script

```
# bash
bundle exec ruby neography_test.rb
```

## Data Visualization

<img src="https://raw.github.com/fiedl/neography_test/master/screenshots/neovigator_screenshot.png" height="400" />

### Neovigator (Recommmended)

[Neovigator](https://github.com/fiedl/neovigator) is a great tool to display your graph. At the moment, the `bundle install` fails due to dependency issues with ruby 2.0. Just use my fork, for the moment:

```bash
git clone git@github.com:fiedl/neovigator.git
cd neovigator
bundle install
rackup
```

Then visit [localhost:9292](http://localhost:9292) to view your graph.

Maybe, you have to type in John's `neo_id` in the neovigator web interface. The `neo_id` is printed out in at the end of the test script within the node information. Just look for `.../node/4/...` in the node information.

### Neo4j Web Administration Tool

The graph data, created in [./neography_test.rb](neography_test.rb) can be visualized using the [neo4j web administration tool](http://127.0.0.1:7474/webadmin), which can be found, locally, at http://127.0.0.1:7474/webadmin.

To visualize the whole graph, click *Data browser* and query
```cypher
START n=node(*)    
MATCH n-[r]->m 
RETURN n as from, r as `->`, m as to;
```
and switch *view mode* (top right button below *documentation*).

*Please note*, this does not work for me. The screen stays grey. That's why I'm recommending Neovigator. If you have a clue, please help. Thanks!

### Gephi

An alternative to display the graph, is to [download Gephi](http://gephi.org/users/download/) and install the *neo4j plugin* from *Extras > Plugins* menu.

Then *import* the graph, which should be located at `neography_test/neo4j/data/graph.db`.


## Data Manipulation

You can play around with the data, either in the regular ruby console, or using `pry`:

```bash
# bash
bundle exec pry --require ./neography_test.rb
```

```ruby
# then, in pry
tarzan = Person.create(name: "Tarzan")
jane = Person.create(name: "Jane", hair: "Blonde")
jane.relates to: tarzan, as: :friend
```


## Resources
* Comments on setting up Neo4J: http://maxdemarzi.com/2012/01/04/getting-started-with-ruby-and-neo4j/
* Neography gem: https://github.com/maxdemarzi/neography
* Neography wiki: https://github.com/maxdemarzi/neography/wiki
* Neography documentation: http://rubydoc.info/github/maxdemarzi/neography/frames
* Neovigator gem to visualize the graph: https://github.com/maxdemarzi/neovigator
* Some basic query commands for using neo4j through the cypher language: http://www.neo4j.org/learn/cypher
