<?php
// $Id: sunstar_aff_pubnews.module,v 1.0 2010/06/22 11:47:37 mmo Exp $
/**************************************************************************************************************************************************************************
 * Description 		: Sunstar affiliates module will determine if the Location with newspaper.
 * Author 			: Michael M. Ocana
 * on 				: August 2010
 * revision         : April 2015 (for Drupal 7)
 * email 			: me@michaelocana.com
 */

/** * Implementation of hook_theme(). 
 *    copy also the template.php in Garland theme
 * @return 
*/
function sunstar_aff_pubnews_theme() { 
	return array(
		'sunstar_aff_pubnews_admin_settings' => array( 
			'arguments' => array(),
		)
	 );
}

/* Implementation of hook_form_alter() for content editing
 * 
 */
function sunstar_aff_pubnews_form_alter(&$form, &$form_state, $form_id){
	if ($form_id == "article_node_form") {
		$form['#after_build'][] = 'alter_content_network_form';
	} elseif ($form_id == "superbalita_node_form") {
		$form['#after_build'][] = 'alter_content_network_form';        
	}
}

/* Implementation of hook_nodeapi
 * 
 * notes :
 * 
 *     in the node-[content].tpl.php add the line <?php echo $content['published_info']['#value']; ?> 
 *     to print published date
 * 
 */
function sunstar_aff_pubnews_node_view($node, $view_mode, $langcode) {
	global $contents_to_check;
	global $bisayan_months;

    $articleType = $node->type;

    $publicationDate = "";
    $publicationDefaultValue = null;  
   
    $published_txt = "";
    if ($node->field_publication_date) {
        $locationId = $node->field_location['und'][0]['tid'];
        $publicationDate = $node->field_publication_date['und'][0]['value'];
        $publicationDefaultValue = $node->field_publication_default_date['und'][0]['value'];    
        if (check_affiliate_if_with_newspaper($locationId)) {	
            if ($view_mode == "full") {
                if (in_array($articleType, $contents_to_check)) {
                    if ($publicationDefaultValue == 1) {
                        // add 1 day if checked
                        $published_date_to_display = strtotime(date("F d, Y", $node->created) . " +1 day");
                        if ($articleType == "superbalita") {
                            $month_number = date("n", $published_date_to_display);
                            $month_number--;
                            $month_string = $bisayan_months[$month_number];
                            $published_date_to_display = $month_string." ".date("d, Y", $published_date_to_display);					
                        } else {
                            $published_date_to_display = date("F d, Y", $published_date_to_display);
                        }
                    } else {
                        // use the date created
                        if ($articleType == "superbalita") {
                            $month_number = date("n", $node->created);
                            $month_number--;
                            $month_string = $bisayan_months[$month_number];
                            $published_date_to_display = $month_string." ".date("d, Y", $node->created);						
                        } else {				
                            $published_date_to_display = date( 'F d, Y', $node->created );
                        }                        
                    }

                    if ($_SERVER['REQUEST_URI'] <> "/" || strlen($_SERVER['REQUEST_URI']) < 1) {
                        $returned_location_name = get_location_name($locationId);
                        // replaced the key location			
                        $published_txt = preg_replace('/{location}/', $returned_location_name, $publicationDate);
                        // replaced the key date						
                    }	                        
                    
                    $published_txt = preg_replace('/{date}/', $published_date_to_display, $published_txt);                
                }
            }
        }
    }
    $node->content['sunstar_date_published_in_newspaper'] = array(
      '#value' => $published_txt,
      '#weight' => 100,
    );    
}

/* Retrieved the Location name of the article
 * @parameter location_id or tid (term data id)
 * @return location_name;
 */
function get_location_name($location_id) {
	$location_name = "";
	$sql = "SELECT name FROM taxonomy_term_data WHERE tid = $location_id";   
	$result = db_query($sql);

	if ($result) {
        foreach ($result as $data) {
            $location_name = stripslashes($data->name); 
        }	
	}    
	
	return $location_name;	
}

/* Check if affiliates with newspaper
 * @return boolean
 * 
*/
function check_affiliate_if_with_newspaper($locationId) {
	$values_with = false;
	$default_with_newspapers = variable_get("sunstar_with_newspaper", array());

	foreach ($default_with_newspapers as $with_newspapers) {
		if ($with_newspapers == $locationId) {
			$values_with = true;
		}
	}
	
	return $values_with;	
}

/* Alter the istorya or Super Balita article entry form
 * 
 */
function alter_content_network_form(&$form) {
	$values_with = "";
	$default_with_newspapers = variable_get("sunstar_with_newspaper", array());
	foreach ($default_with_newspapers as $with_newspapers) {
		if ($with_newspapers > 0) {
			if (strlen($values_with) > 0) {
				$values_with = $values_with . ",'" . $with_newspapers . "'";
			} else {
				$values_with = "'" . $with_newspapers . "'";
			}
		}
	}

	drupal_add_js('
		  jQuery(document).ready(function() {		  	
			var with_newspaper = ['.$values_with.'];

			if (jQuery("#edit-field-location-und").val()) {
				enable_publishing_date(jQuery("#edit-field-location-und").val());	
			} else { 
				jQuery(".group-pub-data").hide();
			}		
					  
			jQuery("#edit-field-location-und").change(function() {
				enable_publishing_date(jQuery(this).val());							
			});
			
			function enable_publishing_date(the_selected) {
				if (jQuery.inArray(the_selected, with_newspaper) < 0) {
					jQuery(".group-pub-data").hide();
				} else {
					jQuery(".group-pub-data").show();
				}				
			}
		  });	
	', 'inline');
	
	return $form;
}

	
/*
 * Form for sunstar_aff_pubnews settings
 * @return form in html object
 */
function sunstar_aff_pubnews_admin_settings($form_state) {
	global $content_types;

	$default_with_newspaper = variable_get("sunstar_with_newspaper", array());
	$contents = implode(",", $content_types);

    $sql = "SELECT ttd.vid, ttd.tid, ttd.name as location "
            . "FROM taxonomy_term_data ttd "
            . "INNER JOIN taxonomy_vocabulary tv ON tv.vid = ttd.vid "
            . "WHERE tv.name IN (". $contents .") "
            . "ORDER BY ttd.weight ASC, ttd.name ASC ";

	$result = db_query($sql);

	if ($result) {
        foreach ($result as $data) {
            $options[$data->tid] = $data->location;
 
            $form[$data->tid]['Location'] = array('#value' => stripslashes($data->location));   
        }	
	}

	$form['sunstar_with_newspaper'] = array(
		'#type' => 'checkboxes',
		'#options' => $options,
		'#default_value' => $default_with_newspaper,
	);	

	if (!empty($_POST) && form_get_errors()) {
		drupal_set_message(t('The settings have not been saved because of the errors.'), 'error');
	}
  	
	$form['submit'] = array(
		'#type' => 'submit',
		'#value' => t('Submit'),
		'#submit' => array('system_settings_form_submit')
	);
 
	$form['cancel'] = array(
		'#type' => 'markup',
		'#value' => l(t('Cancel'), 'admin/content'),
	);	
	
	return $form;
}