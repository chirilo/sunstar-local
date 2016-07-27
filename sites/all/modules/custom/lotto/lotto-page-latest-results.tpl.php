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

<table>
 <tr>
 <th>Lotto Game</th>
 <th>Combinations</td>
 <th>Draw Data</th>
 <th>Jackpot</th>
 <th>Winners</th>
 </tr>
<?php         
  $html = '';

  if (is_array($items)) {

    foreach ($items as $item) {
       $html .= '<tr>';
       $html .= '<td>' .$item->lottogame . '</td>';
       $html .= '<td>' .$item->combination . '</td>';
       $html .= '<td>' .$item->drawdate . '</td>';
       $html .= '<td>' .$item->jackpot . '</td>'; 
       $html .= '<td>' .$item->winners . '</td>';
       $html .= '</tr>';
    }
  }

  print $html;
?>
</table>

