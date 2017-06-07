require 'byebug'

class PolyTreeNode
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(parent_node)
    # debugger
    if @parent
      @parent.children.delete(self)
    end
    @parent = parent_node
    unless parent_node == nil || parent_node.children.include?(self)
      parent_node.children << self
    end
    @parent
  end

  def add_child(child_node)
    child_node.parent=(self)
  end

  def remove_child(child_node)
    if self.children.include?(child_node)
      child_node.parent=(nil)
    else
      raise error
    end
  end

  def dfs(target_value)
    return self if self.value == target_value
    self.children.each do |child_node|
      result = child_node.dfs(target_value)
      if result
        puts "result: #{result.value}"
      else 
        puts "result: #{result}"
      end
      return result if result
    end

    nil
  end

  def bfs(target_value)
    local_arr = [self]
    until local_arr.empty?
      potential_target = local_arr.shift
      puts "potential_target: #{potential_target.value}"
      return potential_target if potential_target.value == target_value
      local_arr += potential_target.children
    end
    nil
  end

end
