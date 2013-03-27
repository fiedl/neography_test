
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

The graph data, created in [./neography_test.rb](neography_test.rb) can be visualized using the [neo4j web administration tool](http://127.0.0.1:7474/webadmin), which can be found, locally, at http://127.0.0.1:7474/webadmin.

To visualize the whole graph, click *Data browser* and query
```cypher
START n=node(*)    
MATCH n-[r]->m 
RETURN n as from, r as `->`, m as to;
```
and switch *view mode* (top right button below *documentation*).

### The Screen Stays Grey

I can't get the graph display of the web administration tool running in each browser. An alternative to display the graph, is to [download Gephi](http://gephi.org/users/download/) and install the *neo4j plugin* from *Extras > Plugins* menu.



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
* http://www.neo4j.org/learn/cypher
