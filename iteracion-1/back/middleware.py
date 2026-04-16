import ctypes, os


def middleware(f):
    current_dir = os.path.dirname(os.path.abspath(__file__))

    # 1. Cargar la librería (asegúrate de que el path sea correcto)
    lib_path = os.path.join(current_dir, "..", "libreria.so")
    lib_path = os.path.normpath(lib_path)

    # Finalmente cargamos
    try:
        mi_lib = ctypes.CDLL(lib_path)
    except OSError as e:
        print(f"No se pudo encontrar la librería en: {lib_path}")
        raise e

    # 2. Configurar los tipos de datos (IMPORTANTE)
    # C no sabe qué le envía Python, hay que definir los tipos de argumentos y retorno
    mi_lib.process_gini_value.argtypes = [ctypes.c_float]
    mi_lib.process_gini_value.restype = ctypes.c_float

    return mi_lib.process_gini_value(f)