<nav class="my-3" aria-label="Page navigation">
    <ul class="pagination justify-content-center">

{assign var='prev_page' value=0}
{foreach from=$navbar.pages key=page item=url}
{if $page == $navbar.CURRENT_PAGE}
        <li class="page-item active"><a class="page-link" href="#">{$page}</a></li>
{else}
        <li class="page-item"><a class="page-link" href="{$url}{if $fragment}#{$fragment}{/if}">{$page}</a></li>
{/if}
{assign var='prev_page' value=$page}
{/foreach}

    </ul>
</nav>
