const { contextBridge, ipcRenderer } = require('electron');

contextBridge.exposeInMainWorld('api', {
  processFiles: (files, options) =>
    ipcRenderer.invoke('process-files', files, options),
  selectSavePath: () => ipcRenderer.invoke('select-save-path'),
});
