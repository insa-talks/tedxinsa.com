<?php

/**
 * Handler for the `wp_enqueue_scripts` action.
 * It is executed at the end of <head> and adds the scripts and styles.
 */
function tedx_insa_enqueue_scripts() {
  $template_url = get_template_directory_uri();
  wp_enqueue_script("tedx-vendor", $template_url . "/dist/js/vendor.js");
  wp_enqueue_script("tedx-app", $template_url . "/dist/js/application.js");
  wp_enqueue_style("parent-style", get_template_directory_uri() . "/style.css");
}

add_action("wp_enqueue_scripts", "tedx_insa_enqueue_scripts");

?>
