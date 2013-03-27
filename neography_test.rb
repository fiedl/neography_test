require 'rubygems'
require 'neography'

class NeoObject
  def initialize(attributes = {})
    # neo4j database adapter, available to all NeoObjects
    @@neo ||= Neography::Rest.new 
    @attributes = Hash(attributes).merge({ type: self.class.name })
    self
  end

  def node
    @node
  end

  def update_attibutes(attributes)
    @neo.set_node_properties(@node, attributes) if @node
  end

  def save
    if @node
      self.update_attributes(@attributes)
    else
      @node = @@neo.create_node(@attributes)
    end
    self
  end

  def self.create(attributes)
    new_object = self.new(attributes)
    new_object.save
    return new_object
  end

  def wipe_database
    @@neo.execute_script("g.clear()") 
  end
  def self.wipe_database
    self.new.wipe_database
  end

  def relates(args)
    if args[:to].kind_of?(NeoObject) && args[:as].kind_of?(Symbol)
      related_object = args[:to]
      relationship_type = "is_#{args[:as]}_of"
      @@neo.create_relationship relationship_type, @node, related_object.node
    end
  end

end

class Person < NeoObject
  def name
    @attributes[:name]
  end
  def name=(name)
    @attributes[:name] = name
  end
end


# wipe database
NeoObject.wipe_database

# create some nodes
john = Person.create(name: "John Doe") 
jane = Person.create(name: "Jane Doe")
christine = Person.create(name: "Christine Doe")

# create some relationships
john.relates to: jane, as: :husband 
christine.relates to: john, as: :child 
christine.relates to: jane, as: :child

# print john's node in order to find out the neo_id
p "John's Node: ", john.node
