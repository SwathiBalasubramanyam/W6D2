require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject

  def self.columns
    if !@columns
      db_res = DBConnection.execute2(<<-SQL)
        select * from #{self.table_name};
      SQL
      @columns = db_res[0].map {|col| col.to_sym}
    end
    @columns
  end

  def self.finalize!
    self.columns.each {|col_name|
      define_method(col_name) do
        self.attributes["#{col_name}"]
      end

      define_method("#{col_name}=") do |val|
        self.attributes["#{col_name}"] = val
      end
    }
  end

  def self.table_name=(table_name)
    @table_name = table_name || self.name.tableize
  end

  def self.table_name
    @table_name ||= self.name.tableize
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    params.each{|attr_name, val|
      raise "Unkown attribute #{attr_name}" unless @columns.include?(attr_name.to_sym)
      self.send(:attr_name, :val)
  }
  end

  def attributes
    @attributes ||= Hash.new
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
