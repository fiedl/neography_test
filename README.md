
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

## Starting the Script

```
# bash
bundle exec ruby neography_test.rb
```

## Data Visualization

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
* http://maxdemarzi.com/2012/01/04/getting-started-with-ruby-and-neo4j/
* https://github.com/maxdemarzi/neography
* https://github.com/maxdemarzi/neovigator
* http://www.neo4j.org/learn/cypher
