# frozen_string_literal: true

# Node in a linked list
class Node
  attr_accessor :value, :next_node

  def initialize(value = nil)
    @value = value
    @next_node = nil
  end
end

# Linked List of Node objects
class LinkedList
  attr_reader :size

  def initialize
    @size = 0
    @head = nil
    @tail = nil
  end

  def append(value)
    # Adds a new node containing `value` to the end of the list
    new_node = Node.new(value)
    if @tail.nil?
      @head = new_node
    else
      @tail.next_node = new_node
    end
    @tail = new_node
    @size += 1
  end

  def prepend(value)
    # Adds a new node containing `value` to the start of the list
    new_node = Node.new(value)
    if @head.nil?
      @tail = new_node
    else
      new_node.next_node = @head
    end
    @head = new_node
    @size += 1
  end

  def at(index)
    # Returns the node at the given `index`
    return nil if index > @size - 1 || index.negative?

    current_node = @head
    (0...index).each do |_idx|
      current_node = current_node.next_node
    end
    current_node
  end

  def pop
    # Removes the last element from the list
    return nil if @size.zero?

    current_node = @head
    if @size == 1
      @head = nil
      @tail = nil
      current_node
    else
      last_node = @tail
      current_node = current_node.next_node until current_node.next_node == @tail
      @tail = current_node
      @tail.next_node = nil
      last_node
    end
  end

  def contains?(value)
    # returns true if the passed in value is in the list and otherwise returns false
    contains_value = false
    current_node = @head
    until current_node.nil?
      if current_node.value == value
        contains_value = true
        break
      end
      current_node = current_node.next_node
    end
    contains_value
  end

  def find(value)
    # returns the index of the node containing `value`, or nil if not found
    return nil if @size.zero?

    idx = 0
    current_node = @head
    until current_node.nil?
      break if current_node.value == value
      current_node = current_node.next_node
      idx += 1
    end
    idx
  end

  def to_s
    # represent your LinkedList objects as strings, so you can print them out and preview them in the console
    # The format should be `( value ) -> ( value ) -> nil`
    str = ''
    current_node = @head
    until current_node.nil?
      str += "#{current_node.value} -> "
      current_node = current_node.next_node
    end
    str += 'nil'
    str
  end
end
