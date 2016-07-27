<?php

/**
 * @file
 * Default theme implementation for lotto block featured results
 *
 * Available variables:
 * - $items
 *
 * @see template_preprocess()
 * @see template_preprocess_aggregator_summary_items()
 *
 * @ingroup themeable
 */
?>
<?php
  $header = array(
    array('data' => t('Game'), 'field' => 'lottogame'),
    array('data' => t('Combinations'), 'field' => 'combination'),
  );

/*
 *  // manual table output
		$html = '<table>
		         <tr>
		         <th>Lotto Game</th>
		         <th>Combinations</td>
		         </tr>';
		foreach ($items as $item) {
		   $html .= '<tr>';
		   $html .= '<td>' .$item[0] . '</td>';
		   $html .= '<td>' .$item[1] . '</td>';
		   $html .= '</tr>';
		}
		$html .= '</table>';
		$output = $html;
*/
  if (is_array($items)) {
    $output = theme('table', array('header' => $header, 'rows' => $items));
    print $output;
  }
?>
<div class="more-lotto"><?php print l(t('More Results'), 'lotto/latest')  ?></div> 
