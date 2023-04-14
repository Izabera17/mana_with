window.onload = function() {
  const spinner = document.getElementById('loading');
  // ローディング後は、spinnerクラスをloadedクラスに置き換える
  spinner.classList.add('loaded');
}