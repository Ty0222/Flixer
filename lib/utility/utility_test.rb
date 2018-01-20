require_relative "../config/utility"
require "minitest/autorun"

class UtilityTest < Minitest::Test

  def test_responds_to_merge_lists_of_paths
    assert_respond_to Utility, :merge_lists_of_paths
  end

  def test_uses_first_index_as_parent_dir_to_indices_thereafter
    paths = ['app/models', 'app/controllers']
    new_paths = ['lib', ['app', 'models/null_objects', 'controllers/filters']]

    Utility.merge_lists_of_paths(path_list: paths, paths_to_add: new_paths)

    assert_includes paths, 'lib'
    assert_includes paths, 'app/models/null_objects'
    assert_includes paths, 'app/controllers/filters'
  end
  
end