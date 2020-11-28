project('sprawl-compositor', 'cpp',
  version : '0.1',
  default_options : ['warning_level=3', 'cpp_std=c++14'])

qt5 = import('qt5')
qt5_dep = dependency('qt5', modules: ['Core', 'Gui', 'Qml'])
qml_files = qt5.preprocess(qresources : 'src/qml.qrc')

executable('sprawl-compositor',
           'src/main.cpp', qml_files,
           dependencies : qt5_dep,
           install : true)
