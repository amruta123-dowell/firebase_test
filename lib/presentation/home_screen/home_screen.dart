import 'package:firebase_test/core/utils/navigator_service.dart';
import 'package:firebase_test/presentation/home_screen/bloc/home_bloc.dart';
import 'package:firebase_test/widgets/custom_dialog.dart';
import 'package:firebase_test/widgets/submit_button.dart';
import 'package:firebase_test/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/custom_snackbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static Widget builder(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc()..add(HomeInitialEvent()),
      child: HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: const Text("Tasks", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: 16, right: 16, bottom: MediaQuery.of(context).padding.bottom),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                if ((state.taskList?.isNotEmpty) ?? false)
                  ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return _TaskContainer(
                          index: index,
                          onClickDelete: (val) {
                            context.read<HomeBloc>().add(
                                OnselectedContainerEvent(selectedIndex: val));
                            openDeleteConfirmDialog(
                                context: context,
                                onClickSubmitDelete: () {
                                  context.read<HomeBloc>().add(
                                          HomeDeleteTaskEvent(
                                              onDeleteFailure: (msg) {
                                        showCustomSnackBar(
                                          context: context,
                                          message: msg,
                                        );
                                      }, onDeleteSuccess: (msg) {
                                        showCustomSnackBar(
                                          context: context,
                                          message: msg,
                                        );
                                      }));
                                },
                                onCloseDialog: () {
                                  context
                                      .read<HomeBloc>()
                                      .add(ClearDataEvent());
                                });
                          },
                          onClickEdit: (val) {
                            context.read<HomeBloc>().add(
                                OnselectedContainerEvent(selectedIndex: val));
                            showAddEditTaskSheet(
                                context: context,
                                homeBloc: context.read<HomeBloc>(),
                                isEdit: true);
                          },
                          taskDetails: state.taskList![index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 12,
                        );
                      },
                      itemCount: state.taskList?.length ?? 0)
                else if (state.taskList == null ||
                    state.taskList?.isEmpty == true)
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "No Task Found",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        onPressed: () {
          context.read<HomeBloc>().add(ClearDataEvent());
          showAddEditTaskSheet(
              context: context,
              homeBloc: context.read<HomeBloc>(),
              isEdit: false);
        },
        backgroundColor: Colors.purple,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

// To open Bottomsheet for editing the task

void showAddEditTaskSheet({
  required BuildContext context,
  required HomeBloc homeBloc,
  required bool? isEdit,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: (innercontext) {
      return BlocBuilder<HomeBloc, HomeState>(
        bloc: homeBloc,
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isEdit! ? "Edit Task" : "Add Task",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFieldWidget(
                  tecController:
                      state.taskController ?? TextEditingController(),
                  title: 'Task',
                  errorText: state.taskFieldError,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFieldWidget(
                    tecController:
                        state.descriptionController ?? TextEditingController(),
                    title: 'Description',
                    errorText: state.taskFieldError),
                const SizedBox(
                  height: 16,
                ),
                TextFieldWidget(
                  enableSuffixIcon: true,
                  tecController:
                      state.dateController ?? TextEditingController(),
                  title: "Date",
                  errorText: state.dateFieldError,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: SubmitButton(
                    onClickButton: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      if (isEdit) {
                        homeBloc.add(HomeEditTaskEvent(onEditFailure: (msg) {
                          showCustomSnackBar(
                            context: context,
                            message: msg,
                          );
                        }, onEditSuccess: (msg) {
                          showCustomSnackBar(
                            context: context,
                            message: msg,
                          );
                        }));
                      } else {
                        homeBloc.add(HomeAddTaskEvent(onAddSuccess: (msg) {
                          showCustomSnackBar(
                            context: context,
                            message: msg,
                          );
                        }, onAddFailure: (msg) {
                          showCustomSnackBar(
                            context: context,
                            message: msg,
                          );
                        }));
                      }
                    },
                    text: isEdit ? "Edit" : "Add",
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

class _TaskContainer extends StatelessWidget {
  final Map<String, dynamic> taskDetails;
  final int index;
  final Function(int index) onClickEdit;
  final Function(int index) onClickDelete;

  const _TaskContainer(
      {super.key,
      required this.taskDetails,
      required this.index,
      required this.onClickEdit,
      required this.onClickDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color.fromARGB(221, 230, 221, 221)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.center,
                  height: 20,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Text("Task ${index + 1}"),
                ),
                Expanded(
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Text("Date - ${taskDetails["date"]}")))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    taskDetails["task"],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "Description",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  taskDetails["description"],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        onClickEdit(index);
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 188, 203, 215),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(Icons.edit)),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        onClickDelete(index);
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 221, 128, 128),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(Icons.delete)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void openDeleteConfirmDialog(
    {required BuildContext context,
    required Function onClickSubmitDelete,
    required Function onCloseDialog}) {
  showDialog(
      context: context,
      builder: (innerContext) {
        return CustomDialog(
            title: "Delete Task?",
            description: "Are your sure about deleting the task? ",
            onClickCancel: () {
              NavigatorClass().pop();
            },
            onClickAccept: () {
              onClickSubmitDelete();
            });
      });
}
