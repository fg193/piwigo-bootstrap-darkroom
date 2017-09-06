{footer_script}
    var error_icon = "{$ROOT_URL}{$themeconf.icon_dir}/errors_small.png", max_requests = {$maxRequests};
{/footer_script}
{* this might sound ridiculous, but we want to fit the thumbnails to 90% of col-xs-12 without them being too blurry *}
{if get_device() !== 'desktop'}
{assign var=width value=520}
{assign var=height value=360}
{else}
{assign var=width value=260}
{assign var=height value=180}
{/if}
{define_derivative name='derivative_params' width=$width height=$height crop=true}
{define_derivative name='derivative_params_square' type=IMG_SQUARE}
{foreach from=$category_thumbnails item=cat name=cat_loop}
{if $theme_config->category_wells == 'never' || ($theme_config->category_wells == 'mobile_only' && get_device() == 'desktop')}
{assign var=derivative value=$pwg->derivative($derivative_params, $cat.representative.src_image)}
{if !$derivative->is_cached()}
    {combine_script id='jquery.ajaxmanager' path='themes/default/js/plugins/jquery.ajaxmanager.js' load='footer'}
    {combine_script id='thumbnails.loader' path='themes/default/js/thumbnails.loader.js' require='jquery.ajaxmanager' load='footer'}
{/if}
{* this needs a fixed size else it messes up the grid on tablets *}
{include file="grid_classes.tpl" width=260 height=180}
<div class="col-outer {if $smarty.cookies.view == 'list'}col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12{else}{$col_class}{/if}" data-grid-classes="{$col_class}">
    <div class="col-inner">
        <a class="col-thumbnail" href="{$cat.URL}">
            <div class="placeholder" style="background: url({$ROOT_URL}{$themeconf.icon_dir}/img_small.png) no-repeat center">
                <img class="img-responsive" {if $derivative->is_cached()}src="{$derivative->get_url()}"{else}src="{$ROOT_URL}themes/bootstrap_darkroom/img/transparent.png" data-src="{$derivative->get_url()}"{/if} alt="{$cat.TN_ALT}" title="{$cat.NAME|@replace:'"':' '|@strip_tags:false} - {'display this album'|@translate}">
            </div>
        </a>
        <div class="caption">
            <h4 class="title">
                <a href="{$cat.URL}" class="ellipsis{if !empty($cat.icon_ts)} recent{/if}">{$cat.NAME}</a>
{if !empty($cat.icon_ts)}
                <img title="{$cat.icon_ts.TITLE}" src="{$ROOT_URL}{$themeconf.icon_dir}/recent{if $cat.icon_ts.IS_CHILD_DATE}_by_child{/if}.png" alt="(!)">
{/if}
            </h4>
{if isset($cat.INFO_DATES) }
            <p>{$cat.INFO_DATES}</p>
{/if}
            <p>{$cat.CAPTION_NB_IMAGES}</p>
{if not empty($cat.DESCRIPTION)}
            <div class="description">{$cat.DESCRIPTION}</div>
{if $theme_config->cat_descriptions}
{html_style}
.content-grid .col-inner .caption .description { display: block; }
{/html_style}
{/if}
{/if}
        </div>
    </div>
</div>
{else}
{assign var=derivative_square value=$pwg->derivative($derivative_params_square, $cat.representative.src_image)}
{if !$derivative_square->is_cached()}
    {combine_script id='jquery.ajaxmanager' path='themes/default/js/plugins/jquery.ajaxmanager.js' load='footer'}
    {combine_script id='thumbnails.loader' path='themes/default/js/thumbnails.loader.js' require='jquery.ajaxmanager' load='footer'}
{/if}
<a class="w-100" href="{$cat.URL}">
  <div class="card">
      <div class="col-lg-4">
         <img class="card-img-left" {if $derivative_square->is_cached()}src="{$derivative_square->get_url()}"{else}src="{$ROOT_URL}themes/bootstrap_darkroom/img/transparent.png" data-src="{$derivative_square->get_url()}"{/if} alt="{$cat.TN_ALT}">
      </div>
      <div class="card-body col-lg-8">
        <h4 class="card-title">{$cat.NAME}</h4>
        <div class="card-text">
{if isset($cat.INFO_DATES) }
            <p>{$cat.INFO_DATES}</p>
{/if}
            <p>{$cat.CAPTION_NB_IMAGES}</p>
{if not empty($cat.DESCRIPTION)}
            <p class="description">{$cat.DESCRIPTION}</p>
{/if}
        </div>
      </div>
  </div>
</a>
{/if}
{/foreach}

