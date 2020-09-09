using UnityEngine;

public class PlasmaBallController : MonoBehaviour {
    public float plasmaDamage = 1f;
    private EnemyData _enemyData;
    private ParticleSystem _particleSystem;
    private readonly string enemyTag = "Enemy";
    private readonly string outOfBounds = "OutOfBounds";

    private void Awake(){
        _particleSystem = GetComponent<ParticleSystem>();
    }

    private void OnEnable(){
        _particleSystem.Play();
    }

    private void OnDisable(){
        _particleSystem.Stop();
    }

    private void OnCollisionEnter(Collision other){
        if (other.gameObject.CompareTag(enemyTag)) {
            other.gameObject.GetComponent<EnemyController>().TakeDamage(plasmaDamage);
            gameObject.SetActive(false);
        }
        else if (other.gameObject.CompareTag(outOfBounds)) {
            gameObject.SetActive(false);
        }
    }

    private void OnTriggerEnter(Collider other){
        if (other.gameObject.CompareTag(enemyTag)) {
            other.gameObject.GetComponent<EnemyController>().TakeDamage(plasmaDamage);
            gameObject.SetActive(false);
        }
        else if (other.gameObject.CompareTag(outOfBounds)) {
            gameObject.SetActive(false);
        }
    }
}