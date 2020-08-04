// These are simple scripts to help importing
// massive amounts of movies through the ui just
// load the import list then accept all
// useful for sonarr as radarr allows checkbox
// selection of all found content
$(".x-add-search").each(function(e, target) {
  return setTimeout(() => {
    console.log("clicking it", target)
    target.click()
  }, 2500)
})
