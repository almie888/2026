(function(){
  const baseAdminEdit=window.adminEdit;
  window.adminEdit=function(){
    baseAdminEdit();
    const panel=document.querySelector('.admin-panel.expanded');if(!panel)return;
    const stored=JSON.parse(localStorage.getItem('gardenSettings')||'{}');
    const fields=panel.querySelector('.admin-fields');
    fields.insertAdjacentHTML('afterbegin',`<label>登录页顶部小标题<input id="s-loginEyebrow" value="${stored.loginEyebrow||'A living visual archive · 2024—2026'}"></label><label>登录页介绍文字<input id="s-loginIntro" value="${stored.loginIntro||''}"></label>`);
    const saveButton=panel.querySelector('.admin-actions button');saveButton.onclick=()=>{const next={...stored,loginEyebrow:panel.querySelector('#s-loginEyebrow').value,loginIntro:panel.querySelector('#s-loginIntro').value};localStorage.setItem('gardenSettings',JSON.stringify(next));if(window.SUPABASE_CONFIG){fetch(`${window.SUPABASE_CONFIG.url}/garden_settings`,{method:'POST',headers:{apikey:window.SUPABASE_CONFIG.anonKey,Authorization:`Bearer ${window.SUPABASE_CONFIG.anonKey}`,'Content-Type':'application/json',Prefer:'resolution=merge-duplicates'},body:JSON.stringify({id:'site',value:next})}).catch(()=>{});}panel.remove();location.reload();};
  };
})();
