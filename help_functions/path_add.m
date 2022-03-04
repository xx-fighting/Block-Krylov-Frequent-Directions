function [new_content] = path_add(content, path)

new_content = content;
n = length(content);
for i = 1:n
    new_content{i} = [path, content{i}];
end

