#!/bin/perl
use strict;
use warnings;

# use lib './lib';
use Rofi::Script;

rofi
  ->set_prompt("Please select one")
  ->add_option("Show markup example")
  ->add_option("Demo row options")
  if rofi->is_initial_call;

SWITCH: for (rofi->shift_arg) {
    next unless $_;

    /markup/ && rofi
        ->set_prompt("markup")
        ->set_message("This is a message")
        ->enable_markup_rows
        ->add_option(qq{<i>You can use pango for markup</i>});

    /row options/ && rofi
        ->set_prompt("row options")
        ->add_option(
          "This is nonselectable", (
            nonselectable => 1,
          ),
        )
        ->add_option(
          "This has metadata" => (
            meta => 'these are metadata terms'
          ),
        );
}

rofi->debug;
rofi->show;
