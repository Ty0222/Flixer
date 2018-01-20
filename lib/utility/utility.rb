module Utility
  extend self

  # The new paths you want to add should be contained in an array with each element being either
  # a single string or an array. It's recommended that you use an array if you have multiple paths
  # you want to include under a particular directory such as 'app'.
  #
  # Within this array, the parent directory should be set as the first index with all of its child paths
  # set within the indices thereafter.
  #
  # Example:
  #
  # original_paths = [ 'app/models', 'app/controllers' ]
  # new_paths = [ 'lib', [ 'app', 'models/null_objects', 'controllers/filters' ] ]
  #
  # Utility.merge_lists_of_paths(path_list: original_paths, paths_to_add: new_paths)
  # #=> original_paths = [ 'app/models', 'app/controllers', 'lib', 'app/models/null_objects', 'app/controllers/filters' ]

  def merge_lists_of_paths(path_list:, paths_to_add:, root_path: nil)
    paths_to_add.each { |new_path| add_new_path(new_path, path_list) }
  end

  private

    def add_new_path(new_path, list)
      new_path.each { |path| 
        parent_dir ||= new_path[0]; list.push "#{parent_dir}/#{path}"
      }
    rescue
      list.push "#{new_path}"
    end

end