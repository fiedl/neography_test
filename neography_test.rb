require 'rubygems'
require 'neography'

class NeoObject < Neography::Node

  def self.create(args, db = Neography::Rest.new)
    subclass_name = self.name  # e.g. Person
    args.merge!({type: subclass_name})
    super(args, db)
  end

  def self.wipe_database
    Neography::Rest.new.execute_script("g.clear()") 
  end

  def relates(args)
    if args[:to].kind_of?(NeoObject) && args[:as].kind_of?(Symbol)
      related_object = args[:to]
      relationship_type = "is_#{args[:as]}_of"
      Neography::Relationship.create relationship_type, self, related_object
    end
  end

end

class Person < NeoObject
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
p "John's Node: ", john
p "John's neo_id: ", john.neo_id
