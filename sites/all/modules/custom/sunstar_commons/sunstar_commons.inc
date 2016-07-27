<?php
// $Id: sunstar_commons.module,v 1.0 2015/04/17 11:47:37 mmo Exp $
/**************************************************************************************************************************************************************************
 * Description 		: Sunstar common module, all the common modules called in the templates.
 * Author 			: Michael M. Ocana
 * on               : April 2015
 * email 			: me@michaelocana.com
 */

/* Implementation of hook_node_view
 * 
 * notes :
 * 
 *     in the node-[content].tpl.php use the following to display variables 
 *     - <?php echo $content['sunstar_with_author_image']['#value']; ?> 
 *     - <?php echo $content['sunstar_term_name_section']['#value']; ?> 
 *     - <?php echo $content['sunstar_author_image_url']['#value']; ?>
 *     - <?php echo $content['sunstar_author_name']['#value']; ?>
 * 
 * return values :
 *     sunstar_with_author_image : boolean, True/False
 *     sunstar_term_name_section : string, Opinion/Sports/Lifestyle
 *     sunstar_author_image_url : string
 *     sunstar_author_name : string
 */
function sunstar_commons_node_view($node, $view_mode, $langcode) {
    $fieldAuthor = $node->field_author['und'][0]['taxonomy_term'];
    $fieldAuthorImage = null;
    if (isset($fieldAuthor->field_author_image['und'])) {
      $fieldAuthorImage = $fieldAuthor->field_author_image['und'][0]['uri'];
    }
    $imageUrl = file_create_url($fieldAuthorImage);
    if ($node->type == "superbalita") {
        $opinionId = $node->field_seksyon['und'][0]['tid']; 
    } else {
        $opinionId = $node->field_mt_post_categories['und'][0]['tid']; 
    }
    $term = taxonomy_term_load($opinionId);
    
    $withAuthorImage = false;
    if ($fieldAuthorImage) {
      $withAuthorImage = true;
    }
    $node->content['sunstar_with_author_image'] = array(
      '#value' => $withAuthorImage,
      '#weight' => 100,
    );    
    $node->content['sunstar_term_name_section'] = array(
      '#value' => $term->name,
      '#weight' => 101,
    );     
    $node->content['sunstar_author_image_url'] = array(
      '#value' => $imageUrl,
      '#weight' => 102,
    );  
    $node->content['sunstar_author_name'] = array(
      '#value' => $fieldAuthor->name,
      '#weight' => 102,
    );    
}
