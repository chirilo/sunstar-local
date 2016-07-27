<?php
// $Id: 

/**
 * @file
 * User page callbacks for the lotto module.
 */

/**
 * Menu callback; displays the most recent items gathered from any feed.
 *
 * @return
 *   The items HTML.
 */
function lotto_latest_results() {
  $latestdate = lotto_get_latest_date();
  
  $sql = "SELECT lottogame, combination, drawdate, jackpot, winners
          FROM {lotto}
          WHERE drawdate = :drawdate
          ORDER BY drawdate DESC";
  $result = db_query($sql, array(':drawdate' =>$latestdate));
  $items = array();
  foreach ($result as $item) {
    $items[] = $item;
  }
  $out = theme('lotto_page_latest_results', array('items' => $items));
  return $out;
}
