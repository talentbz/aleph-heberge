<?php

class Image extends Intervention\Image\ImageManagerStatic
{
}

Image::configure(['driver' => 'gd']);
