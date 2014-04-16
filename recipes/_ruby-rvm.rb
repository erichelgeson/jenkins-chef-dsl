
node.set['rvm']['global_gems'] = [
  { 'name'    => 'bundler' }
]

node.set['rvm']['rubies'] = [
  "ruby-2.1.1"
]
node.set['rvm']['gems'] = {
  'ruby-2.1.1@chef.v1' => [
    { 'name'    => 'chef' },
    { 'name'    => 'berkshelf' },
    { 'name'    => 'foodcritic' },
    { 'name'    => 'chefspec' },
  }
  ],
  'ruby-2.1.1@empty-gemset' => []
}

node.set['rvm']['default_ruby'] = 'ruby-2.1.1'

include_recipe 'rvm::system'
