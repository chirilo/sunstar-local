<article id="node-<?php print $node->nid; ?>" class="<?php print $classes; ?> clearfix"<?php print $attributes; ?>>
  
  <!-- node-content-wrapper -->
  <div id="printArea" class="node-content-wrapper clearfix">

    <?php if ( $page && ($share_links || $print_button || $font_resize || $display_submitted || $post_progress || $reading_time )) { ?>
    
    <?php } ?>

    <!-- node-content -->
    <!-- div class="node-content clearfix <!-- ?php if (!($share_links || $print_button || $font_resize || $display_submitted || $post_progress || $reading_time) || (!$page)) { print ' ' . 'full-width'; } ?> " -->
      <header>
        <?php print render($title_prefix); ?>
        <?php if (!$page) { ?>
          <h2 <?php print $title_attributes; ?> class="title"><a href="<?php print $node_url; ?>"><?php print $title; ?></a></h2>
        <?php } else { ?>
          <h1 class="title" <?php print $title_attributes; ?>><?php print $title; ?></h1>
        <?php } ?>
        <?php print render($title_suffix); ?>

          <div class="node-info">
            <!-- div class="node-info-item"><i class="fa fa-clock-o"></i> <!-- ?php print format_date($created, 'custom', 'l, F d, Y '); ?></div -->
            <?php if (isset($content['field_author'])) { ?>
            <!-- display author image in opinion only -->            
            <div class="node-info-item">
                <?php if ($content['sunstar_with_author_image']['#value'] && $content['sunstar_term_name_section']['#value'] == "Opinion") { ?>
                <img src="<?php print $content['sunstar_author_image_url']['#value']; ?>" alt="<?php print $content['sunstar_author_name']['#value']; ?>" />
                <?php } ?>               
                <i class="fa fa-user"></i> <?php print t('By ');?><?php print render($content['field_author']) . render($content['field_column']) ;  ?>
            </div>
            <?php } ?>
            <!-- display author in opinion only -->
          </div>
      </header>

      <div class="content clearfix"<?php print $content_attributes; ?>>
        <?php
          // We hide the comments and links now so that we can render them later.
          hide($content['comments']);
          hide($content['links']);
		  /* hide the publication date and default, avoid rendering in front end */
		  hide($content['field_publication_date']);
          hide($content['field_publication_default_date']);
          print render($content);
        ?>
		<div class="related-article">
         <?php
         $views_block = module_invoke('views','block_view','related_articles-block');
         print render($views_block);
         ?>
        </div>
		
		<h2 style="font-weight:700;">Columns</h2>
				

<?php

  // get URL and query the tid of the author's name
  $d = 'node/' . arg(1);  
  $dalias = drupal_get_path_alias($d);  
  $dcomponent = explode('/', $dalias);
  $author_name = str_replace('-', ' ', $dcomponent[1]);
  $author = db_query("SELECT tid FROM {taxonomy_term_data} WHERE LOWER(REPLACE(name, '.', ''))  = '" .  $author_name . "'")
            ->fetchAllAssoc('tid');

  //print $d . '<br>';
  //print $dalias . '<br>';
  //print_r($dcomponent); // an array
  //print '<br>';
  //print $author_name . '<br>';
  print_r($author); // an array
  print '<br><br>';

  if ($author) {
    $query = new EntityFieldQuery();    

    $result = $query
               ->entityCondition('entity_type', 'node')
               ->entityCondition('bundle', 'article')
               // get only nodes that are 'published'
               ->propertyCondition('status', 1)
              // replace field_food_menu with field_TAXONOMY_NAME
              // replace 2 with the taxonomy ID (tid) you're wanting
              ->fieldCondition('field_author', 'tid', $author[1]->tid)
              ->pager(20)
              ->execute();

    print $author[1];
    print $author[0];

   
    if (isset($result['node'])) {
      print $result['node'];
      $nodes = node_load_multiple(array_keys($result['node']));
      print render(node_view_multiple($nodes, 'teaser')) . theme('pager');
      print "naay sulod<br>";

    } else {
      print "wlay sulod";
    }

  }
?>
		 
		 
		 
		 		<h2 style="font-weight:700;">Columns From Views</h2>
				<?php
$str = "Mary Had A Little Lamb and She LOVED It So";
$str = strtolower($str);
echo $str; // Prints mary had a little lamb and she loved it so
?>
		 <?php
         $views_block = module_invoke('views','column','column_block');
         print render($views_block);
         ?>
		 
		 
		 
      </div>
      
      <?php if ($links = render($content['links'])): ?>
      <footer class="node-footer">
      <?php print render($content['links']); ?>
      </footer>
      <?php endif; ?>

      <?php print render($content['comments']); ?>
    </div>
    <!-- EOF:node-content -->

  </div>
  <!-- EOF: node-content-wrapper -->

</article>
