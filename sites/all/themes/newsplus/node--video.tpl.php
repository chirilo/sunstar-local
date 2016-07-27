<?php 
$reading_time = theme_get_setting('reading_time');
$share_links = theme_get_setting('share_links');
$print_button = theme_get_setting('print_button');
$font_resize = theme_get_setting('font_resize');
$post_progress = theme_get_setting('post_progress');
?>
<article id="node-<?php print $node->nid; ?>" class="<?php print $classes; ?> clearfix"<?php print $attributes; ?>>
  
  <!-- node-content-wrapper -->
  <div id="printArea" class="node-content-wrapper clearfix">

    <?php if ( $page && ($share_links || $print_button || $font_resize || $display_submitted || $post_progress || $reading_time )) { ?>
    <!-- node-side -->
    <div class="node-side">
      
      <?php if ($display_submitted) { ?>
      <div class="user-info">
        <?php print $user_picture; ?>
        <?php if ($display_submitted) { ?>
        <?php print t('By ');?> <?php print $name; ?>
        <?php } ?>
      </div>
      <?php } ?>
      
      <?php if ($reading_time) { ?>
      <!-- reading-time -->
      <div class="reading-time">
        <div><?php print t('Time to read')?></div>
          
        <?php 
        $node_content = $content;
        $node_content = render($node_content); 
        $words = str_word_count(strip_tags($node_content));
        $minutes = floor($words / 275);
        if ($minutes<1) { 
        print '<span>' . t('less than<br> 1 minute' . '</span>'); 
        } elseif ($minutes<2) {
        print '<span>' . $minutes . t(' minute') . '</span>';  
        } else {
        print '<span>' . $minutes . t(' minutes') . '</span>'; 
        }
        ?>
          
      </div>
      <!-- EOF: reading-time -->
      <?php } ?>
      
      <?php if ($share_links || $print_button || $font_resize || $display_submitted || $post_progress) { ?>
      <!-- #affix -->
      <div id="affix">
        
        <?php if ($share_links) { ?>
         <!-- share-links -->
        <div class="share-links">
          <?php print t('Share'); ?>
          <?php $path = isset($_GET['q']) ? $_GET['q'] : '<front>'; ?>
      <link rel="stylesheet" href="/sites/all/themes/newsplus/social-share-kit.css" type="text/css">
        <script type="text/javascript" src="/sites/all/themes/newsplus/js/social-share-kit.js"></script>
        <script type="text/javascript" src="/sites/all/themes/newsplus/js/social-share-kit.min.js"></script>
        <script>(function($){$(document).ready(function(){SocialShareKit.init({
          'url': 'http://www.sunstar.com.ph<?php echo $node_url; ?>',
           twitter: {
            title: "<?php echo $title . ' | Sun.Star'; ?>",
            url: 'http://www.sunstar.com.ph<?php echo $node_url; ?>',
            text: '',
            via: 'sunstaronline'
          }
          });});})(jQuery);</script>
        <!--<script type="text/javascript">SocialShareKit.init();</script>-->
      <ul>
      <li><div class="ssk-rounded ssk-count"><a href="" class="ssk ssk-facebook ssk-sm"></a></div></li>
      <li><div class="ssk-rounded ssk-count"><a href="" class="ssk ssk-twitter ssk-sm"></a></div></li>
      <li><div class="ssk-rounded ssk-count" data-url="http://www.sunstar.com.ph<?php echo $node_url; ?>"><a href="" class="ssk ssk-google-plus ssk-sm"></a></div></li>
      <li><div class="ssk-rounded ssk-count" data-url="http://www.sunstar.com.ph<?php echo $node_url; ?>"><a href="" class="ssk ssk-email ssk-sm"></a></div></li>
            
      </ul>
        </div>
        <!-- EOF:share-links -->
        <?php } ?>
        
        <?php if ($print_button || $font_resize || $display_submitted) { ?>
        <!-- submitted-info -->
        <div class="submitted-info">
          <?php if ($print_button) { ?>
          <div class="print">
            <i class="fa fa-print"></i> <a href="javascript:PrintElem()" target="_blank" class="print-button"> <?php print t(' Print')?></a>
          </div>
          <?php } ?>
          <?php if ($font_resize) { ?>
          <div class="font-resize">
            <a href="#" id="decfont">a-</a>
            <a href="#" id="incfont">a+</a>
          </div>
          <?php } ?>
          <?php if ($display_submitted) { ?>
          <div class="submitted-info-item">
            <?php print t('Published')?>
            <span><?php print $posted_ago; ?><?php print t(' ago')?></span>
          </div>
          <div class="submitted-info-item">
            <?php print t('Last updated')?>
            <span><?php print $changed_ago; ?><?php print t(' ago')?></span>
          </div>
          <?php } ?>
        </div>
        <!--EOF: submitted-info -->
        <?php } ?>
        
        <?php if ($post_progress) { ?>
        <!-- post-progress -->
        <div class="post-progress">
          <?php print t('Read so far')?>
          <span class="post-progress-value"></span>
          <div class="post-progressbar"></div>
        </div>
        <!-- EOF: post-progress -->
        <?php } ?>
      
      </div>
      <!-- EOF:#affix -->
      <?php } ?>

    </div>
    <!-- EOF:node-side -->
    <?php } ?>

    <!-- node-content -->
    <div class="node-content clearfix <?php if (!($share_links || $print_button || $font_resize || $display_submitted || $post_progress || $reading_time) || (!$page)) { print ' ' . 'full-width'; } ?> ">
      <header>
        <?php print render($title_prefix); ?>
        <?php if (!$page) { ?>
          <h2 <?php print $title_attributes; ?> class="title"><a href="<?php print $node_url; ?>"><?php print $title; ?></a></h2>
        <?php } else { ?>
          <h1 class="title" <?php print $title_attributes; ?>><?php print $title; ?></h1>
        <?php } ?>
        <?php print render($title_suffix); ?>

          <div class="node-info">
            <div class="node-info-item"><i class="fa fa-clock-o"></i> <?php print format_date($created, 'custom', 'l, F d, Y '); ?></div>
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
		<p id="publication"><strong><?php echo strip_tags($content['sunstar_date_published_in_newspaper']['#value']);	?></strong></p>
	
       <!--Outbrain widget -->
        <div class="base pad-bottom">
        <div class="OUTBRAIN" data-src="http://www.sunstar.com.ph<?php echo $node_url; ?>" data-widget-id="AR_3" data-ob-template="sunstar" ></div>
        <script type="text/javascript" async="async" src="http://widgets.outbrain.com/outbrain.js"></script>
        </div>

    <!-- Facebook comment  -->
	<div class="fb-comments">
	<p style="margin: 0 auto; width:100%; margin-top:1em;border-top: dashed 1px #a5a5a5;  padding-top: 1em;"><strong>DISCLAIMER:</strong>  Sun.Star website welcomes friendly debate, but comments posted on this site do not necessary reflect the views of the Sun.Star management and its affiliates. Sun.Star reserves the right to delete, reproduce or modify comments posted here without notice. Posts that are inappropriate will automatically be deleted.<br /><br /><strong>Forum rules:</strong> Do not use obscenity.  Some words have been banned. Stick to the topic.  Do not veer away from the discussion.  Be coherent and respectful. Do not shout or use CAPITAL LETTERS!</p>
	<div id="fb-root"></div>
	<script>(function(d, s, id) {
	var js, fjs = d.getElementsByTagName(s)[0];
	if (d.getElementById(id)) return;
	js = d.createElement(s); js.id = id;
	js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.3&appId=170014129740511";
	fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));</script>

      <div style="margin-top:0px;margin-left:-3px;padding:5px 8px; background:#f0f0f0; border: 1px dashed #c3c3c3;">
      <div class="fb-comments" data-href="http://www.sunstar.com.ph/<?php echo $nid; ?>" data-width="100%" data-numposts="5" data-colorscheme="light" data-mobile="true" data-version="v2.3"></div>
      </div>
      </div>
	  <!-- EOF: Facebook comment -->

	  <!--Disqus-->
      <div id="disqus_thread"></div>
      <script type="text/javascript">
    /* * * CONFIGURATION VARIABLES * * */
    var disqus_shortname = 'sunstarphilippines';
    
    /* * * DON'T EDIT BELOW THIS LINE * * */
    (function() {
        var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
        dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
        (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
    })();
      </script>
      <noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript" rel="nofollow">comments powered by Disqus.</a></noscript>
      <!--EOF: Disqus -->
			
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