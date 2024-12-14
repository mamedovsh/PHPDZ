<?php

namespace Geekbrains\Application1;

use Twig\Loader\FilesystemLoader;
use Twig\Environment;
use Exception;

class Render {

    private string $viewFolder = '/src/Views/';
    private FilesystemLoader $loader;
    private Environment $environment;

    public function __construct(){
        $this->loader = new FilesystemLoader(dirname(__DIR__) . $this->viewFolder);
        $this->environment = new Environment($this->loader, [
            // 'cache' => $_SERVER['DOCUMENT_ROOT'].'/cache/',
        ]);
    }

    public function renderPage(string $contentTemplateName = 'page-index.twig', array $templateVariables = []) {
        $template = $this->environment->load('/layouts/main.twig');
        
        $templateVariables['content_template_name'] = $contentTemplateName;
        $templateVariables['title'] = 'имя страницы';

        return $template->render($templateVariables);
    }
    
    public static function renderExceptionPage(Exception $e) {
        $templateVariables = [
            'error_message' => $e->getMessage(),
            'error_code' => $e->getCode(),
        ];

        $loader = new FilesystemLoader(dirname(__DIR__) . '/src/Views/');
        $environment = new Environment($loader);
        $template = $environment->load('/layouts/error.twig');

        return $template->render($templateVariables);
    }
}

class UserController {
    
    public function updateUser(array $data) {
        if (!isset($data['id']) || !isset($data['name'])) {
            throw new Exception('ID и имя пользователя обязательны');
        }

        $userId = (int)$data['id'];
        $newName = $data['name'];
return "Пользователь с ID $userId обновлён с новым именем: $newName";
    }

    public function deleteUser(int $userId) {
        return "Пользователь с ID $userId удалён";
    }
}