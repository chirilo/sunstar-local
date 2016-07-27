<?php 
$currrent_id = arg(1);
$count = 0;

foreach ($rows as $id => $row) {
    $nid = $view->result[$id]->nid;
    $nodes_ids[$count] = $nid;
    $title[$count] = $row; 
    $count++;
}

$current_node_key =  array_search($currrent_id, $nodes_ids);
sort($nodes_ids);

reset($nodes_ids);
$nid_min = key($nodes_ids);

end($nodes_ids);         		// move the internal pointer to the end of the array
$nid_max = key($nodes_ids);		// fetches the key of the element pointed to by the internal
?>
<div class="node-navigation clearfix">
	<div class="col-xs-6">
	<?php if ( $current_node_key != $nid_min ) {?>
		<div class="prev-node <?php if ($current_node_key == $nid_max) { print ' ' . 'last-article'; } ?>">
		<div class="text">Prev article</div>
		<?php	$prev_node = $title[$current_node_key-1];
		print $prev_node; ?>
		</div>
		<i class="fa fa-angle-left"></i>
	<?php }?>
	</div>
	<div class="col-xs-6">
	<?php if ( $current_node_key != $nid_max ) {?>
		<div class="next-node">
		<div class="text">Next article</div>
		<?php	$next_node = $title[$current_node_key+1];
		print $next_node; ?>
		</div>
		<i class="fa fa-angle-right"></i>
	<?php }?>
	</div>
</div>