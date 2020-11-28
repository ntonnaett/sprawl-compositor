project('sprawl-compositor', 'cpp',
  version : '0.1',
  default_options : ['warning_level=3', 'cpp_std=c++14'])

qt5 = import('qt5')
qt5_dep = dependency('qt5', modules: ['Core', 'Gui', 'Qml'])
qml_files = qt5.preprocess(qresources : 'qml.qrc')

add_project_arguments('-DQT_QPA_EGLFS_ALWAYS_SET_MODE=1', language : 'cpp')
executable('sprawl-compositor',
           'main.cpp', qml_files,
           dependencies : qt5_dep,
           install : true)
