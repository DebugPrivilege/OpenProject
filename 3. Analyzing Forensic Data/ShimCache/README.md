# ShimCache

ShimCache, also known as the AppCompatCache, is a feature of Windows that records information about executables that have been accessed on a system. It logs details such as the file path, size, and last modification time but does not track actual execution or timestamp of execution. Its primary purpose is to ensure compatibility of applications when Windows updates are applied. 

ShimCache is useful for determining whether a file was present on the system, even if it was deleted or not executed. However, like AmCache, it cannot confirm program execution definitively.
