function[] = set_RRT_globals()
    global num_nodes node_it step_length_3D step_size closest_to_target_node_it;
    num_nodes = 10000;
    node_it = 1;
    step_length_3D = 0.1;
    step_size = 0.05;
    closest_to_target_node_it = 1;
end