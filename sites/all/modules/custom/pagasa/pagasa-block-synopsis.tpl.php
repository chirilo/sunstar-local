<?php

/**
 * @file
 * Default theme implementation to dollar peso rate
 *
 * Available variables:
 * - $dollarpeso
 *
 * @see template_preprocess()
 * @see template_preprocess_aggregator_summary_items()
 * @ingroup themeable
 */
?>
<div id="weather" class="ext-service append-bottom">
<p><?php print $content['data2'] ?></p>
<?php
/* <img src="<?php print base_path() . drupal_get_path('module', 'pagasa') .'/wxsymbols/wxsym_4s.jpg'?>" width="50" height="50" alt="" />
*/
?>
<a rel="nofollow" target="_blank" href="http://www.pagasa.dost.gov.ph/">PAGASA</a></div>

