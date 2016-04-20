#
# Cookbook Name:: build-cookbook
# Recipe:: smoke
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
include_recipe 'delivery-truck::smoke'

# Create a search query that matches the current environment.
search_query = "chef_environment:#{delivery_environment}"

# Run the query.
nodes = delivery_chef_server_search(:node, search_query)

# cURL the IP address of each result and verify a 200 (OK) response.
nodes.each do |node|
  address = node['ipaddress']
  execute "cURL #{address} and verify 200 response" do
    command "curl -IL #{address} | grep '^HTTP/1\.1 200 OK'"
  end
end
